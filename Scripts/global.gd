extends Node

var players: Array[String]
var current_player = 0
var round = 1
var player_colors = [Color("7f6ac7"), Color("4aa249"), Color("df6a00"), Color("ac1b2f")]
var beginning_check = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
var winner : String = "test"
