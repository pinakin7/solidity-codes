import keyInput from "./KeyInput.js";

import connect from "./Connect.js";

const colorPallete = [0x053C5E, 0x1D3958, 0x353652, 0x4C334D, 0x643047, 0x7C2E41, 0x942B3B, 0xAB2836, 0xC32530, 0xDB222A, 0xd00000, 0xffffff];

const ratio = window.innerWidth / window.innerHeight;

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, ratio, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const light = new THREE.AmbientLight(0x404040);
const dLight = new THREE.DirectionalLight(0xffffff, 0.5);
light.add(dLight);
scene.add(light);

const geometry = new THREE.BoxGeometry(50, 0.1, 50);
const material = new THREE.MeshPhongMaterial({ color: 0xffffff });
const ground = new THREE.Mesh(geometry, material);
scene.add(ground);

camera.position.set(5, 15, 15);




function animate() {

    // infinite loop

    requestAnimationFrame(animate);

    if(keyInput.isPressed(37)){
        camera.position.x -= 0.05;
    }
    if(keyInput.isPressed(38)){
        camera.position.y += 0.05;
    }
    if(keyInput.isPressed(39)){
        camera.position.x += 0.05;
    }
    if(keyInput.isPressed(40)){
        camera.position.y -= 0.05;
    }
    

    camera.lookAt(ground.position);
    renderer.render(scene, camera);
}

animate();


connect.then((res)=>{
    console.log(res);

    res.buildings.forEach((building, index) => {
        if(index <= res.supply){
            const boxGeometry = new THREE.BoxGeometry(building.w, building.h, building.d);
            const boxMaterial = new THREE.MeshPhongMaterial({color:colorPallete[index]});
            const box = new THREE.Mesh(boxGeometry, boxMaterial);
            box.position.set(building.x, building.y, building.z);

            scene.add(box);
        }
    });

});