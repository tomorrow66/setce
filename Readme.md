Screen Sized
============

- [**Routes (Sinatra)**](#routes)
 - Sinatra
 - Hot Reloading
 - Sessions
 - Views
 - Public Files
- [**Tasks (Rake)**](#tasks)
 - Task Files
 - IRB
 - Environments
- [**Data (DataMapper)**](#data)
 - Setup
 - Models
 - Tasks
 - Debugging
- [**Testing (MiniTest)**](#testing)
 - Writing Tests
 - Running Tests
- [**Libraries**](#libraries)
 - DateTime (Chronic)
 - Markdown (Redcarpet)
 - Mobile Request Routing
 - Numbers
 - Strings
 - Views
- [**Sending Email (Pony)**](#sending-email)
 - Settings
 - Sending
- [**Logs**](#logs)
 - Log Files
 - Writing & Clearing
 - Tasks
- [**Front End**](#front-end)
 - HTML
 - CSS
 - JS
- [**Merging**](#merging)
 - Creating an Application to Merge
 - Merging With Another Application

<a name="routes"></a>
Routes (Sinatra)
----------------

### Sinatra

Screen Sized uses Sinatra to handle routes, which should be defined in the /routes folder. Everything Sinatra can do with route handling is inherited by your Screen Sized application.

The /routes folder can contain as many nested files and folders as necessary.

Example of a GET request route handler (http://localhost:9292/handle-with-care):

    get '/handle-with-care/?' do
      @my_var = 'Variables starting with the @ symbol get passed to views.'
      view 'handle_with_care' # Renders /views/handle_with_care.html
    end

> More info on Sinatra: http://www.sinatrarb.com/

> **Pro Tip:** Routes can also be defined in /models and /helpers.

---

### Hot Reloading

By using [sinatra/reloader](https://github.com/sinatra/sinatra-contrib), Screen Sized applications will reload changed code without having to restart the server when in the development environment.

> **Note:** This doesn't apply to DataMapper model changes.

---

### Sessions

Sessions are enabled by default in Screen Sized.

To set a session variable:

    session[:my_var] = 'This will persist between page loads'

To clear session variables:

    session.clear

---

### Views

View files are stored in /views.

The default layout file is /views/layout.html.

Ruby is embedded in normal .html using the standard <%= %> tags.

> More info on ERB: http://ruby-doc.org/stdlib-1.9.3/libdoc/erb/rdoc/ERB.html

---

### Public Files

Stylesheets, JavaScripts, images, and any other files a browser would need to request directly go in /public.

> **Note:** /public is the only publicly accessible folder

<a name="tasks"></a>
Tasks (Rake)
------------

Screen Sized supports running Rake tasks with the standard rake command. Your application will preloaded and available to all tasks.

---

### Task Files

Store your custom Rake tasks in /tasks.

---

### IRB

The irb task will load your application into an IRB session:

    rake irb

---

### Environments

You can specify the environment your task runs in with the env argument:

    rake irb env=production

If you don't specify an environment, it will default to development.

> **Pro Tip:** env= replaces RACK\_ENV=. environment= and rack_env= also work.

<a name="data"></a>
Data (DataMapper)
-----------------

Databases are handled with DataMapper. Like routes and Sinatra, everything DataMapper can do is inherited by your Screen Sized application.

> More info on DataMapper: http://datamapper.org/

---

### Setup

Before using DataMapper, you'll need to choose a type of database and it's associated gems. You can choose between an in-memory datastore, SQLite, MySQL, and PostgreSQL. SQLite is enabled by default.

To choose another gem, uncomment it's line in Gemfile.

To setup your chosen database, uncomment it's line in /settings/datamapper.rb and fill out the required options.

> Be sure to choose a database for both development and production environments.

> **Note:** The default SQLite databases are created in /data.

---

### Models

Models are standard DataMapper model classes, stored in /models and automatically loaded into your application and tasks.

    class Widget
    include DataMapper::Resource

      property   :id,         Serial
      property   :deleted_at, ParanoidDateTime
      timestamps :at

      property :name,        String
      property :description, Text

    end

> **Pro Tip:** Like routes, models can also be defined in /routes and /helpers.

---

### Tasks

Screen Sized comes with tasks designed to work with DataMapper.

    # Create a new database from your models (this will destroy existing data)
    rake dm:migrate

    # Apply constructive changes in your models to the database (non-destructive)
    rake dm:upgrade

    # Run the /data/seeds.rb script against your database
    # Seed data should be data required to start and run your application
    rake dm:seed

    # Run the /data/transmogrify script against your database
    # This should be used to alter existing data
    rake dm:transmogrify

    # Combines dm:migrate and dm:seed
    rake dm:setup

    # Combines dm:setup and rackup
    rake build

You can choose the environment and database tasks run against with the env= option

    rake dm:setup env=production

> Like all tasks, if you don't choose an environment, it will default to development.

---

### Debugging

DataMapper can output it's queries to your console. Uncomment this line in /settings/datamapper.rb for your desired environment:

    DataMapper::Logger.new $stdout, :debug

<a name="testing"></a>
Testing (MiniTest)
------------------

Screen Sized includes tasks for running MiniTest against the /tests folder.

---

### Writing Tests

Write a standard test case and save it in /tests (widget_test.rb):

    class WidgetTest < MiniTest::Unit::TestCase

      def test_made_by
        my_gadget = Widget.new
        assert_equal my_gadget.made_by, 'Acme Corp.'
      end

    end

---

### Running Tests

You can run all your tests at once:

    rake minitest

Or one file at a time:

    rake minitest file=widget_test

<a name="libraries"></a>
Libraries
---------

Ruby code that doesn't fit neatly into models or routes should be put in /libraries.

---

### DateTime (Chronic)

/libraries/date_time.rb adds the following methods for working with dates:

##### display

> Converts a Date, Time or DateTime object into a human readable string.

    d = DateTime.now

    d.display
    => 'Thursday Dec 15, 2011'

    d.display(:date)
    => 'Thursday Dec 15, 2011'

    d.display(:day)
    => 'Dec 15, 2011'

    d.display(:day_with_time)
    => 'Dec 15, 2011 at 11:51pm'

    d.display(:american_day)
    => '12/15/11'

##### to_fields

> Converts a Date, Time or DateTime object into form fields.

> Requires a select field name argument.The generated select fields will end with _year, _month and _day.

    # This will generate 'my_date_year', 'my_date_month' and 'my_date_day'

    d = DateTime.now
    d.to_fields('my_date')
    => "<select name='my_date_month' id='my_date_month'><option value='1' >1</option><option value='2' >2</option><option value='3' >3</option><option value='4' >4</option><option value='5' >5</option><option value='6' >6</option><option value='7' >7</option><option value='8' >8</option><option value='9' >9</option><option value='10' >10</option><option value='11' >11</option><option value='12' selected>12</option></select><select name='my_date_day' id='my_date_day'><option value='1' >1</option><option value='2' >2</option><option value='3' >3</option><option value='4' >4</option><option value='5' >5</option><option value='6' >6</option><option value='7' >7</option><option value='8' >8</option><option value='9' >9</option><option value='10' >10</option><option value='11' >11</option><option value='12' >12</option><option value='13' >13</option><option value='14' >14</option><option value='15' selected>15</option><option value='16' >16</option><option value='17' >17</option><option value='18' >18</option><option value='19' >19</option><option value='20' >20</option><option value='21' >21</option><option value='22' >22</option><option value='23' >23</option><option value='24' >24</option><option value='25' >25</option><option value='26' >26</option><option value='27' >27</option><option value='28' >28</option><option value='29' >29</option><option value='30' >30</option><option value='31' >31</option></select><select name='my_date_year' id='my_date_year'><option value='2007' >2007</option><option value='2008' >2008</option><option value='2009' >2009</option><option value='2010' >2010</option><option value='2011' selected>2011</option><option value='2012' >2012</option><option value='2013' >2013</option><option value='2014' >2014</option></select>"

##### from_fields

> Converts a year, month and day string into a database DateTime object.

> This example is based on the fields generated in the above 'to_fields' example, as if they were passed from a form.

    Date.from_fields(params[:my_date_year], params[:my_date_month], params[:my_date_day])
    => 2011-12-15 12:00:00 -0500

---

### Markdown (Redcarpet)

/libraries/markdown.rb adds a method for converting markdown text into html:

##### markdown

    h = '# This is a header'
    h.markdown
    => '<h1>This is a header</h1>\n'

---

### Mobile Request Routing

/libraries/mobile_request.rb allows you to define separate view files for mobile devices:

##### view

> If the request is coming from a mobile device, will try to show view.mobile.html before defaulting to view.html.

> Also works with layout files.

> Replaces Sinatra's erb method, using the same options (view file, layout, locals, etc.).

    view 'hello'

---

### Numbers

/libraries/number.rb adds the following methods for working with numbers:

##### dollarize

> Converts a number to a dollar

> **Note:** This isn't a currency conversion, it's only a string.

    1.dollarize
    => '$1.00'

##### even?

> Returns true if a number is even.

    2.even?
    => true

##### odd?

> Returns true if a number is odd.

    2.even?
    => false

##### truncate\_to\_decimal

> Truncates a number to a float (The standard truncate methods returns an integer).

> The dec argument determines how many digits to leave after the decimal; it defaults to 1.

> **Note:** Removes trailing 0s.

    1.234.truncate_to_decimal 2
    => 1.23

---

### Strings

/libraries/string.rb adds the following methods for working with strings:

##### titleize

> Capitalizes the first letter of each word in a string.

    'This is a title'.titleize
    => 'This Is A Title'

##### truncate

> Truncates by word count (not letter).

> Arguments: word_count (defaults to 100), end_string (defaults to '…')

    'One Two Three Four Five'.truncate 3
    => 'One Two Three...'

---

### Views

/libraries/view.rb adds the following Sinatra helpers for working with views:

##### active

> Adds a class of 'active' to an element that matches the page url.

> Accepts a string or an array.

    <a href="#" class="<%= active '/home' %>">Home</a>
    => <a href="#" class="active">Home</a>

##### alert

> Displays an alert message div.

> **Note:** Will only display on the next page load.

    session[:flash] = 'Your message here.'  # Before page loads, usually in a route that redirects
    <%= alert =>                            # In your view or layout
    => "<div id='alert'>Your message here.</div>"

##### hidden

> Hides an element.

> **Note:** Works will with if/unless (hidden unless @var.empty?).

    <div style="<%= hidden %>">Content to hide</div>

<a name="sending-email"></a>
Sending Email (Pony)
---------------------

Screen Sized uses Pony to send emails.

---

### Settings

You can set your email server settings in /settings/email.rb. Here's an example using Gmail:

    set :mail_server, {
      address: 'smtp.gmail.com',
      port: '587',
      enable_starttls_auto: true,
      user_name: 'you@gmail.com', # Google Apps domains also work here
      password: '********',
      authentication: :plain
    }

---

### Sending

Sends email using default settings:

    Pony.mail(
      via: :smtp,
      via_options: settings.mail_server,
      to: 'you@example.com',
      subject:'This is a sample email',
      body: 'Can you read me now?'
    )

<a name="logs"></a>
Logs
----

### Log Files

Screen Sized stores log files in /log using plain text .log files.

---

### Writing & Clearing

The log.rb library provides the following methods for working with log files:

##### message

> Writes to log/messages.log.

    Log.message('This is my message.')

##### write_errors

> Writes errors to a log file named after the running environment.

    before do
      Log.write_errors request
    end

##### write\_requests\_and\_errors

> Writes errors and requests to a log file named after the running environment.

    before do
      Log.write_requests_and_errors request
    end

##### clear

> Clears out a log file.

    Log.clear('messages')

---

### Tasks

Logs can also be cleared using the following rake task:

    rake log:clear file=messages

<a name="front-end"></a>
Front End
---------

### HTML

The layout file provides basic HTML5 elements, ready for your content.

---

### CSS

Screen Sized comes with enough CSS to give your design a jumpstart:

**reset.css** resets all the default browser styles. Based on Eric Meyer's reset.css.

**layout.css** provides a responsive 12 grid layout system, including offsets.

    <div class="grid">
      <div class="row">
        <div class="column six">Content goes here…</div>
        <div class="column six">and here.</div>
      </div>
    </div>

**typography.css** sets up basic typography, including vertical rhythm.

**forms.css** styles form elements for all the main browsers, including mobile.

**theme.css** is for overriding the defaults. This is where most of your css work will go.

---

### JS

The default layout.html contains both jQuery and a script to hide the address bar on iPhones.

<a name="merging"></a>
Merging
-------

It's possible to reuse components from Screen Sized applications by storing them in git repositories and merging them with future applications.

---

### Creating an Application to Merge

Any Screen Sized application can be used for merging so long as it resides in an accessible git repo, such as on GitHub. Because the merged files will overwrite any existing files of the same name, it's best to remove all unnecessary files in the to-be-merged application and, if possible, name the remaining files and directories so as to avoid any possible conflicts.

---

### Merging With Another Application

The merge command will download another Screen Sized application from a repo and combine it with your application.

Run this command from within your application:

    screensized -merge git@github.com:repo.git

> **Important:** Files from the to-be-merged application will replace existing files of the same name.