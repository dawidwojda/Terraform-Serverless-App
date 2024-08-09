import './App.css';
import { Component } from 'react';
import Comments from './Comments';
import AddComment from './AddComment';

export default class App extends Component {
  constructor() {
    super();
    this.state = {
      apiUrl: "https://38swcmzir2.execute-api.eu-central-1.amazonaws.com"
    }
  }

  render() {
    return (
      <div className="App">
        <Comments getUrl={this.state.apiUrl} />
        <AddComment postUrl={this.state.apiUrl} />
      </div>
    )
  }
}
