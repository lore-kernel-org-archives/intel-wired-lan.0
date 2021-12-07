From: Hayes Wang <hayeswang@realtek.com>
Date: Tue, 7 Dec 2021 07:28:02 +0000
Subject: [Intel-wired-lan] [RFC PATCH 0/4] r8169: support dash
In-Reply-To: <20211203070410.1b4abc4d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211129101315.16372-381-nic_swsd@realtek.com>
 <20211129095947.547a765f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <918d75ea873a453ab2ba588a35d66ab6@realtek.com>
 <20211130190926.7c1d735d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d3a1e1c469844aa697d6d315c9549eda@realtek.com>
 <20211203070410.1b4abc4d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <e2fd429a489545e7a521283600cb7caa@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, December 3, 2021 11:04 PM
[...]
> Ah, I've only spotted the enable/disable knob in the patch.
> If you're exchanging arbitrary binary data with the FW we
> can't help you. It's not going to fly upstream. 

How is it that we only provide certain basic settings,
such as IPv4 address, IPv6 address, and so on? Then,
they are not the arbitrary binary data.

Could devlink param be used for more than 4 bytes settings?
At least the IPv6 address is longer.

Besides, we need the information of SMBIOS which could
be 4K ~ 8K bytes data. Is there any way we could transmit
it to firmware?

Best Regards,
Hayes


