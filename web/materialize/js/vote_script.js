
var iterationCount = 1000;
var keySize = 128;
var encryptionKey  ="Abcdefghijklmnop";
var iv = "dc0da04af8fee58593442bf834b30739"
var salt = "dc0da04af8fee58593442bf834b30739"

var AesUtil = function(keySize, iterationCount) {
    this.keySize = keySize / 32;
    this.iterationCount = iterationCount;
};

AesUtil.prototype.generateKey = function(salt, passPhrase) {
    var key = CryptoJS.PBKDF2(passPhrase, CryptoJS.enc.Hex.parse(salt),{ keySize: this.keySize, iterations: this.iterationCount });
    return key;
}

AesUtil.prototype.encrypt = function(salt, iv, passPhrase, plainText) {
    var key = this.generateKey(salt, passPhrase);
    var encrypted = CryptoJS.AES.encrypt(
        plainText,
        key,
        { iv: CryptoJS.enc.Hex.parse(iv) });
    return encrypted.ciphertext.toString(CryptoJS.enc.Base64);
}

AesUtil.prototype.decrypt = function(salt, iv, passPhrase, cipherText) {
    var key = this.generateKey(salt, passPhrase);
    var cipherParams = CryptoJS.lib.CipherParams.create({
        ciphertext: CryptoJS.enc.Base64.parse(cipherText)
    });
}

function encrypt(msg){

    var aesUtil = new AesUtil(keySize, iterationCount);
    var cipher=  aesUtil.encrypt(salt, iv, encryptionKey, msg);
    return cipher;

}
function decodeUTF8(s) {
    var i, d = unescape(encodeURIComponent(s)), b = new Uint8Array(d.length);
    for (i = 0; i < d.length; i++) b[i] = d.charCodeAt(i);
    return b;
}

function calculate_digest(msg) {
    var h = new BLAKE2s(32);
    h.update(decodeUTF8(msg));
    h = h.hexDigest();
    console.log(h);
    return h;
}

function completeForm() {
   var msg = document.querySelector('input[name="g1"]:checked').value.replace(/\r\n/g, '\n');
    console.log("plain text "+msg);
    var encryptedVote=encrypt(msg).toString();
    var hashedVote=calculate_digest(msg).toString();
    document.getElementById("encryptedVote").value=encryptedVote;
    document.getElementById("hashedVote").value=hashedVote;
    console.log('encryptedVote'+ document.getElementById("encryptedVote").value);
    console.log('hashedVote'+document.getElementById("hashedVote").value);
    return true;
}

