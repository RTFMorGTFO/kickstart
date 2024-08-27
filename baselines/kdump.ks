#### creates and adds kdump file ###

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

# Keyboard layouts
keyboard --xlayouts='us'
# System language
lang en_US.UTF-8
