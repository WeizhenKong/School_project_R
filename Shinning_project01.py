#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov 30 12:14:55 2019

@author: kongweizhen
"""
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output
import plotly.graph_objs as go
import pandas as pd


df = pd.read_excel('https://s3.amazonaws.com/programmingforanalytics/NBA_data.xlsx')

app = dash.Dash(__name__)

app.css.append_css({
    'external_url': 'https://codepen.io/chriddyp/pen/bWLwgP.css'
})

#numerical_features = ['James Harden','Paul George','Giannis Antetokounmpo','Joel Embiid','LeBron James','Stephen Curry','Kawhi Leonard','Devin Booker','Kevin Durant','Anthony Davis','Damian Lillard','Kemba Walker','Bradley Beal','Blake Griffin','Karl-Anthony Towns','Kyrie Irving','Donovan Mitchell','Zach LaVine','Russell Westbrook','Klay Thompson']
#numerical_features = ['Name','Age','Games_played']
options_dropdown = [{'label':x.upper(), 'value':x} for x in numerical_features]

dd_x_var = dcc.Dropdown(
        id='x-var',
        options = options_dropdown,
        value = 'Name'
        )

div_x_var = html.Div(
        children=[html.H4('Player 1'), dd_x_var],
        className="six columns"
        )

dd_y_var = dcc.Dropdown(
        id='y-var',
        options = options_dropdown,
        value = 'Name'
        ) 

div_y_var = html.Div(
        children=[html.H4('Player 2'), dd_y_var],
        className="six columns"
        )

app.layout = html.Div(children=[
        html.H1('Comparison'),
        html.H2('Two players'),
        html.Div(
                children=[div_x_var, div_y_var],
                className="row"
                ), 
        dcc.Graph(id='scatter')
        ])

@app.callback(
        Output(component_id='scatter', component_property='figure'),
        [Input(component_id='x-var', component_property='value'), Input(component_id='y-var', component_property='value')])
def scatter_plot(x_col, y_col):
    
    trace = go.Scatter(
            x = df[x_col],
            y = df[y_col],
            mode = 'markers'
            )
    
    layout = go.Layout(
            title = 'Scatter plot',
            xaxis = dict(title = x_col.upper()),
            yaxis = dict(title = y_col.upper())
            )
    
    output_plot = go.Figure(
            data = [trace],
            layout = layout
            )
    
    return output_plot

if __name__ == '__main__':
    app.run_server(debug=True)