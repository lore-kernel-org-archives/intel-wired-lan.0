From: Hayes Wang <hayeswang@realtek.com>
Date: Fri, 3 Dec 2021 07:57:08 +0000
Subject: [Intel-wired-lan] [RFC PATCH 0/4] r8169: support dash
In-Reply-To: <20211130190926.7c1d735d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211129101315.16372-381-nic_swsd@realtek.com>
 <20211129095947.547a765f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <918d75ea873a453ab2ba588a35d66ab6@realtek.com>
 <20211130190926.7c1d735d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <d3a1e1c469844aa697d6d315c9549eda@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, December 1, 2021 11:09 AM
[...]
> I'm not sure how relevant it will be to you but this is the
> documentation we have:
> 
> https://www.kernel.org/doc/html/latest/networking/devlink/index.html
> https://www.kernel.org/doc/html/latest/networking/devlink/devlink-params.ht
> ml
> 
> You'll need to add a generic parameter (define + a short description)
> like 325e0d0aa683 ("devlink: Add 'enable_iwarp' generic device param")
> 
> In terms of driver changes I think the most relevant example to you
> will be:
> 
> drivers/net/ethernet/ti/cpsw_new.c
> 
> You need to call devlink_alloc(), devlink_register and
> devlink_params_register() (and the inverse functions).

I have studied the devlink briefly.

However, I find some problems. First, our
settings are dependent on the design of
both the hardware and firmware. That is,
I don't think the others need to do the
settings as the same as us. The devlink
seems to let everyone could use the same
command to do the same setting. However,
most of our settings are useless for the
other devices.

Second, according to the design of our
CMAC, the application has to read and
write data with variable length from/to
the firmware. Each custom has his own
requests. Therefore, our customs would
get different firmware with different
behavior. Only the application and the
firmware know how to communicate with
each other. The driver only passes the
data between them. Like the Ethernet
driver, it doesn't need to know the
contend of the packet. I could implement
the CMAC through sysfs, but I don't
know how to do by devlink.

In brief, CMAC is our major method to
configure the firmware and get response
from the firmware. Except for certain information,
the other settings are not standard and useless
for the other vendors.

Is the devlink the only method I could use?
Actually, we use IOCTL now. We wish to
convert it to sysfs for upstream driver.

Best Regards,
Hayes

