
$TARGET_DIR = "C:\Users\frenz\OneDrive\Desktop\mp3_music"
$EXT = "wma"
$FFMPEG = "C:\Users\frenz\AppData\Local\Microsoft\WinGet\Links/ffmpeg"
$ROOT_PATH = "C:\Users\frenz\OneDrive\Desktop\Dad's Music"
function Convert-Dir {
    param ([string]$dir)
    Write-Output $dir
    
    $files = Get-ChildItem -Path ($ROOT_PATH + $dir) -File

    #create new folder in target dir, before converting files in album/dir
    try {
        New-Item -Path ($TARGET_DIR + "\" + $dir) -ItemType Directory
    }
    catch {
        Write-Output $_.ExceptionMEssage
    }

    foreach ($file in $files) {
        #file names include .wma extension, need to strip to add .mp3 extenstion for output
        $file_strip = $file.Name.Substring(0, ($file.Name.Length - 4))
        & $FFMPEG -i ($ROOT_PATH + "\" + $dir + "\" + $file) ($TARGET_DIR + "\" + $dir + "\" + $file_strip + ".mp3")
    }

    $subdirs = Get-ChildItem -Path ($ROOT_PATH + $dir) -Directory


    foreach ($subdir in $subdirs) {
        Convert-Dir -dir ($dir + "/" + $subdir)
    }

}



Convert-Dir -dir ""


# New-Item -Path ($TARGET_DIR + "\leel") -ItemType Directory
# & $FFMPEG -i ($ROOT_PATH + "\testdir\05 Moral Kiosk.wma") ($TARGET_DIR + "\05 Moral Kiosk.mp3")


