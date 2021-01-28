enum PlayersPositions {
  goalkeeper,
  right_wing,
  left_wing,
  centre_back,
  line_player,
  left_back,
  right_back
}

const Map<PlayersPositions, String> PlayersPositionsName = {
  PlayersPositions.goalkeeper: "Gol",
  PlayersPositions.right_wing: "Ponta direita",
  PlayersPositions.left_wing: "Ponta esquerda",
  PlayersPositions.centre_back: "Central",
  PlayersPositions.line_player: "Pivô",
  PlayersPositions.left_back: "Meia esquerda",
  PlayersPositions.right_back: "Meia direita",
};
