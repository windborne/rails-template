# Rails Template

Usage:
```bash
rails new your_app_name -m https://raw.githubusercontent.com/windborne/rails-template/refs/heads/main/template.rb -J -T
```

This will set up a new Rails application.
`cd your_app_name` and run `foreman start -f Procfile.dev` to start the app.
You can go to http://localhost:3000 to see the app running.

## Things to try

### Create a new scaffold
```bash
rails g scaffold Post title:string body:text
rails db:migrate
```

Read about [scaffolding in the Rails guides](https://guides.rubyonrails.org/v3.2/getting_started.html#getting-up-and-running-quickly-with-scaffolding).
Tl;dr: this command will create everything you need for a basic CRUD (Create, Read, Update, Delete) interface, from the form to the database.

### Embed a react component in a view
Add a new file `app/javascript/components/hello_world.jsx` with the following content:
```jsx
import React from 'react';
import PropTypes from 'prop-types';

export default class HelloWorld extends React.PureComponent {
    static propTypes = {
        name: PropTypes.string.isRequired,
    };

    render() {
        return (
            <div>
                <h1>Hello, {this.props.name}!</h1>
            </div>
        );
    }
}
```

Then, in a view file (eg `app/views/posts/index.html.erb`), add the following line:
```erb
<%= react_component('hello_world', { name: 'Looney' }) %>
```

Note that you can pass in props from rails land, eg `{ name: @post.title }`.

### Deploy to a remote host
Edit `config/deploy.yml`, following the comments, then run `kamal deploy`.
This uses kamal/docker under the hood.

## Other libraries to consider
- For auth, use [devise](https://github.com/heartcombo/devise)
- For state management on the frontend across many components, use redux (it does come pre-installed with this template, but you'll have to set up a store yourself)
- If you're doing tons of background jobs, use [sidekiq](https://github.com/sidekiq/sidekiq)
- If there are a lot of clients or other processes need to talk to the database, switch to postgres

None of these are set up by default to keep things simple.

## What's different from vanilla Rails?
1. Sets up react-rails
2. Tweaks the rubocop config slightly
3. Uses rspec instead of minitest
4. Adds annotaterb

## TODO
- Set up cursor rules
- Add a `--no-react` flag to skip react-rails
- Add a `--sidekiq` flag to set up sidekiq
- Create a default SCSS file for global styles
