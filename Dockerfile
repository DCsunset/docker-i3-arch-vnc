ARG VERSION

FROM archlinux:${VERSION:-latest}
LABEL MAINTAINER="DCsunset"

# copy directory contents to /scripts
COPY ./scripts /scripts

ARG NDK_VERSION=r24
RUN sed -i 's/SigLevel.*/SigLevel = Never/' /etc/pacman.conf && sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf && sed -i 's/#Color/Color/' /etc/pacman.conf && sed -i 's/CheckSpace/#CheckSpace/' /etc/pacman.conf && rm -rv /etc/pacman.d/gnupg/ && pacman -Syu reflector archlinux-keyring wget --noconfirm  && pacman-key --init && pacman-key --populate archlinux && reflector --ipv4 @/etc/xdg/reflector/reflector.conf && pacman -Syyu $(pacman -Qnq) --overwrite=/* --noconfirm  && pacman --noconfirm --needed -Syu man-db base-devel base nano unzip go git bash bash-completion mc openssh zip htop python-pip pacutils pacman-contrib && wget -4 -t 1 https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux.zip -P /opt/ && cd /opt && unzip ./android-ndk-${NDK_VERSION}-linux.zip && rm -f /opt/*.zip && useradd -m -g users -G log,systemd-journal,power,daemon -s /bin/bash docker_user && echo "docker_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && cd /home/docker_user/ && git clone https://aur.archlinux.org/yay.git && chown -R docker_user:users ./yay && cd yay && sudo -u docker_user /usr/bin/makepkg -scCrfi --noconfirm && cd ../ && rm -rf ./yay/ && sudo -u docker_user /usr/bin/yay -S zsh zsh-systemd-git zsh-sudo-git zsh-completions zsh-you-should-use zsh-autosuggestions zsh-autopair-git zsh-syntax-highlighting icdiff beautysh nano-syntax-highlighting-git downgrade cmake --noconfirm && sudo -u docker_user /usr/bin/yay -Sc --noconfirm && chsh -s /bin/zsh root && chsh -s /bin/zsh docker_user && sudo -u docker_user /usr/bin/wget http://sprunge.us/6g1UXG -P /home/docker_user/ && sudo -u docker_user /usr/bin/mv /home/docker_user/6g1UXG /home/docker_user/.zshrc && echo "include /usr/share/nano-syntax-highlighting/*.nanorc" > /etc/nanorc && ln -sv /home/docker_user/.zshrc /root/.zshrc && rm -f /var/cache/pacman/pkg/*.pkg.tar.* && wget https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/pacman/trunk/pacman.conf -O ./pacman.conf && mv ./pacman.conf /etc/pacman.conf && sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf && sed -i 's/#Color/Color/' /etc/pacman.conf && sed -i 's/CheckSpace/#CheckSpace/' /etc/pacman.conf && passwd -d docker_user

WORKDIR /root

EXPOSE 5900 6080

CMD [ "/scripts/start.sh" ]
