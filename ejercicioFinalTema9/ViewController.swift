//
//  ViewController.swift
//  ejercicioFinalTema9
//
//  Created by user184221 on 3/7/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sliderSong: UISlider!
    @IBOutlet weak var labelSong: UILabel!
    @IBOutlet weak var labelSFDK: UILabel!
    @IBOutlet weak var labelVioladores: UILabel!
    @IBOutlet weak var labelMala: UILabel!
    @IBOutlet weak var labelTote: UILabel!
    @IBOutlet weak var labelShotta: UILabel!
    
    //array de imagenes
    let image = [ #imageLiteral(resourceName: "sfdk"), #imageLiteral(resourceName: "violadores"), #imageLiteral(resourceName: "mala"), #imageLiteral(resourceName: "toteking"), #imageLiteral(resourceName: "shotta")]
    //Gestor para imagenes y canciones
    var manager = 0
    //Variable AudioPlayer
    var player : AVAudioPlayer!
    //Array canciones
    let songs = ["LosFuncionarios", "VioladoresVivirParaContarlo", "MalaPorLaNoche", "TotePuzzle", "ShottaGanador"]
    let nameSongs = ["SFDK - Los Funkcionarios", "Violadores del verso - Vivir para contarlo", "Mala Rodríguez - Por la noche", "Toteking - Puzzle", "Shotta - Ganador"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ponemos las imagenes
        imageView.image = image[manager]
        //Inicializamos el player
        initPlayer()
        //Sacamos el nombre de la canción
        labelSong.text = "\(nameSongs[manager])"
        //Actualizamos la interfaz gráfica marcando la canción que se esta seleccionada
        GraphicInterface()
        //Creamos una variable timer para actualizar el tiempo de la canción
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SliderTime), userInfo: nil, repeats: true)
    }

    //Action de botón canción anterior
    @IBAction func PreviousSong(_ sender: Any) {
        //Si el gestor es mayor que 0
        if manager > 0 {
            //Restamos un valor al gestor
            manager = manager - 1
            //Mostramos la nueva imagen
            imageView.image = image[manager]
            //Iniciamos la canción
            initPlayer()
            player.play()
            //Sacamos el nombre de la canción
            labelSong.text = "\(nameSongs[manager])"
            //Actualizamos la interfaz gráfica marcando la canción que se esta seleccionada
            GraphicInterface()
        }
    }
    
    //Action de boton siguiente canción
    @IBAction func NextSong(_ sender: Any) {
        //si el el gestor es menor que 4
        if manager < 4 {
            //Sumamos un valor al gestor
            manager = manager + 1
            //Mostramos la nueva imagen
            imageView.image = image[manager]
            //Iniciamos la canción
            initPlayer()
            player.play()
            //Sacamos el nombre de la canción
            labelSong.text = "\(nameSongs[manager])"
            //Actualizamos la interfaz gráfica marcando la canción que se esta seleccionada
            GraphicInterface()
        }
    }
    
    //Action de botón play
    @IBAction func PlaySong(_ sender: Any) {
        //Si la canción esta sonando
        if player.isPlaying{
            //Pausamos la canción
            player.pause()
            //Cambiamos el icono a play
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }else{      //Si no
            //Iniciamos la canción
            player.play()
            //Cambiamos al icono de pause
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    //función para inicializar el reproductor
    func initPlayer() {
        //Creamos la url de la información del archivo
        let url = Bundle.main.url(forResource: songs[manager], withExtension: "mp3")
        //Pasamos la url al player
        player = try? AVAudioPlayer(contentsOf: url!)
        player.delegate = self
        //El valor máximo del slider será igual a la duración de la canción
        sliderSong.maximumValue = Float(player.duration)
    }
    
    /*func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }*/
    
    //función para la interfaz gráfica que nos marque que canción estamos escuchando
    func GraphicInterface(){
        switch manager {
        case 0:
            labelSFDK.backgroundColor = UIColor.white
            labelVioladores.backgroundColor = .none
            labelMala.backgroundColor = .none
            labelTote.backgroundColor = .none
            labelShotta.backgroundColor = .none
            break
        case 1:
            labelSFDK.backgroundColor = .none
            labelVioladores.backgroundColor = UIColor.white
            labelMala.backgroundColor = .none
            labelTote.backgroundColor = .none
            labelShotta.backgroundColor = .none
            break
        case 2:
            labelSFDK.backgroundColor = .none
            labelVioladores.backgroundColor = .none
            labelMala.backgroundColor = UIColor.white
            labelTote.backgroundColor = .none
            labelShotta.backgroundColor = .none
            break
        case 3:
            labelSFDK.backgroundColor = .none
            labelVioladores.backgroundColor = .none
            labelMala.backgroundColor = .none
            labelTote.backgroundColor = UIColor.white
            labelShotta.backgroundColor = .none
            break
        case 4:
            labelSFDK.backgroundColor = .none
            labelVioladores.backgroundColor = .none
            labelMala.backgroundColor = .none
            labelTote.backgroundColor = .none
            labelShotta.backgroundColor = UIColor.white
            break
        default:
            print("ERROR")
        }
    }
    
    //Función para calcular el tiempo de la canción
    @objc
    func SliderTime(){
        //El tiempo del slider será el tiempo de la canción
        sliderSong.value = Float(player.currentTime)
    }
    
    //Action del slider para mover el momento de la canción
    @IBAction func updateSong(_ sender: UISlider) {
        player.pause()
        player.currentTime = TimeInterval(sender.value)
        player.play()
    }
}
