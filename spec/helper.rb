require 'spec'
DIR = File.dirname __FILE__
require DIR + '/../lib/jspp'
require 'fakeweb'

PETS = "Cat, dog, turtle, hamster, parrot\n"
PETS_URL = 'http://elv1s.ru/x/pets.txt'
FakeWeb.register_uri :get, PETS_URL, :body => PETS
EXAMPLE = DIR + '/../example'
CHILD_CSS = File.read(EXAMPLE + '/css/style-child.css')
FakeWeb.register_uri :get, 'http://nv.github.com/js-preprocessor/example/css/style-child.css', :body => CHILD_CSS
