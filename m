From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 28 Jan 2016 12:28:18 -0800
Subject: [Intel-wired-lan] i210 backplane link (link-mode 1000BASE-KX)
Message-ID: <CAJ+vNU1YjyY=BgGPFpMU8wk9hWOKrHXSiffW-HntcNUAubRtDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Greetings,

I have two i210's from separate boards connected together via SERDES
and am unable to get packets across the interfaces. The interconnect
has board1's TXP/TXN (pin 52/53) connected to board2's RXP/RXN (pin
50/49) and visa-versa via nothing but 0.1uf de-coupling caps (AC
coupled). The SERDS_SIG_DET pin (54) is pulled-up indicating a link
present.

The internal NVM is configured such that the link-mode is 1000BASE-KX
and when I bring up both NIC's they appear to sense a 1000mbps
full-duplex connection but then shortly after trying to send a packet
they both hit a netdev timeout on the NIC.

Any ideas what I might be doing wrong here? Should the Linux 4.4 igb
driver be able to handle a 1000BASE-KX link mode without driver
modification?

Regards,

Tim
