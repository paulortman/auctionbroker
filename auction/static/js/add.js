const MyApp = createReactClass ({
    render(){
        return <h1>Hello from React {React.version}</h1>
    }
})

ReactDOM.render(
    <MyApp/>,
    document.getElementById('root_add')
)