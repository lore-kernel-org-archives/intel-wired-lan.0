From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 28 Jan 2016 20:44:34 +0000
Subject: [Intel-wired-lan] i210 backplane link (link-mode 1000BASE-KX)
In-Reply-To: <CAJ+vNU1YjyY=BgGPFpMU8wk9hWOKrHXSiffW-HntcNUAubRtDw@mail.gmail.com>
References: <CAJ+vNU1YjyY=BgGPFpMU8wk9hWOKrHXSiffW-HntcNUAubRtDw@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65AB28C27@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Can you file this through IPS or through your FAE? I think we should probably have more tracking/focus on this than we can provide through this mailing list.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Tim Harvey
Sent: Thursday, January 28, 2016 12:28 PM
To: intel-wired-lan@lists.osuosl.org; Kirsher, Jeffrey T
Cc: Marek Va?ut
Subject: [Intel-wired-lan] i210 backplane link (link-mode 1000BASE-KX)

Greetings,

I have two i210's from separate boards connected together via SERDES and am unable to get packets across the interfaces. The interconnect has board1's TXP/TXN (pin 52/53) connected to board2's RXP/RXN (pin
50/49) and visa-versa via nothing but 0.1uf de-coupling caps (AC coupled). The SERDS_SIG_DET pin (54) is pulled-up indicating a link present.

The internal NVM is configured such that the link-mode is 1000BASE-KX and when I bring up both NIC's they appear to sense a 1000mbps full-duplex connection but then shortly after trying to send a packet they both hit a netdev timeout on the NIC.

Any ideas what I might be doing wrong here? Should the Linux 4.4 igb driver be able to handle a 1000BASE-KX link mode without driver modification?

Regards,

Tim
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
