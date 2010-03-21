require 'spec'
DIR = File.dirname __FILE__
require DIR + '/../lib/jspp'
require 'fakeweb'

PETS = "Cat, dog, turtle, hamster, parrot\n"
PETS_URL = 'http://elv1s.ru/x/pets.txt'
FakeWeb.register_uri :get, PETS_URL, :body => PETS
EXAMPLE = DIR + '/../example'
CHILD_CSS = File.read(EXAMPLE + '/css/child.css')
FakeWeb.register_uri :get, 'http://js-preprocessor.com/example/css/child.css', :body => CHILD_CSS
