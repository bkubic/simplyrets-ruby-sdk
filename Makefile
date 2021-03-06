
FILES=$(shell git ls-files lib/ spec/ example.rb simplyrets.gemspec)

generate: ruby-client.zip
	rm -rf ruby-client/
	unzip ruby-client.zip
	cp -r ruby-client/lib/swagger_client.rb lib/simplyrets.rb
	cp -r ruby-client/lib/swagger_client/* lib/simplyrets/

	sed -i 's/SwaggerClient/SimplyRetsClient/g' $(FILES)
	sed -i 's/swagger_client/simplyrets/g' $(FILES)
	sed -i 's/VERSION = "1.0.0"/VERSION = "2.0.0"/g' $(FILES)
	sed -i 's/simplyrets (1.0.0)/simplyrets (2.0.0)/g' $(FILES)

	git grep -I --name-only -z -e '' | \
		xargs -0 sed -i -e 's/[ \t]\+\(\r\?\)$$/\1/'

	patch -p1 < multi-query-param.patch

ruby-client.zip:
	curl -XPOST http://generator.swagger.io/api/gen/clients/ruby			\
		--verbose -D - --fail --show-error --insecure -s			\
		-H 'Origin: http://editor.swagger.io'					\
		-H 'Referer: http://editor.swagger.io'					\
		-H 'Accept: application/json'						\
		-H 'Content-Type: application/json'					\
		-d '{"swaggerUrl": "https://docs.simplyrets.com/api/resources.json"}'	\
		-o ruby-client.meta

	cat ruby-client.meta | \
		jq --raw-output .link | \
		xargs curl  --output ruby-client.zip

example:
	bundle exec ./example.rb

test:
	bundle exec rspec

release:
	gem build simplyrets.gemspec
	#gem push simplyrets-2.0.0.gem

clean:
	rm -f ruby-client.zip
	rm -f ruby-client.meta
	rm -rf ruby-client
