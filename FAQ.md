## FAQ


### 1 - Why didn't you use [Savon](https://github.com/savonrb/savon) as a dependency to handle the SOAP requests ?

Two main reasons :
- When I started to work on the Orias wrapper, the API was serving a broken SOAP format that could not be handled by savon (not without tweaks).
- Savon is a bit on the heavy side concerning dependencies (with Nokogiri, Akami & Wasabi).


### 2 - Why didn't you use [Nokogiri](https://github.com/sparklemotion/nokogiri) to parse responses and build requests ?

Mostly to keep a light dependencies list. There's only one API method in the Orias API (as of today), so `libxml-to-hash` & `libxml-ruby` are plainly sufficient.
