From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 30 Nov 2021 19:09:26 -0800
Subject: [Intel-wired-lan] [RFC PATCH 0/4] r8169: support dash
In-Reply-To: <918d75ea873a453ab2ba588a35d66ab6@realtek.com>
References: <20211129101315.16372-381-nic_swsd@realtek.com>
 <20211129095947.547a765f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <918d75ea873a453ab2ba588a35d66ab6@realtek.com>
Message-ID: <20211130190926.7c1d735d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 1 Dec 2021 02:57:00 +0000 Hayes Wang wrote:
> Jakub Kicinski <kuba@kernel.org>
> > Sent: Tuesday, November 30, 2021 2:00 AM
> > Subject: Re: [RFC PATCH 0/4] r8169: support dash
> > 
> > On Mon, 29 Nov 2021 18:13:11 +0800 Hayes Wang wrote:  
> > > These patches are used to support dash for RTL8111EP and
> > > RTL8111FP(RTL81117).  
> > 
> > If I understand correctly DASH is a DMTF standard for remote control.
> > 
> > Since it's a standard I think we should have a common way of
> > configuring it across drivers.  
> 
> Excuse me. I am not familiar with it.
> What document or sample code could I start?
> 
> > Is enable/disable the only configuration
> > that we will need?  
> 
> I don't think I could answer it before I understand the above way
> you mentioned.
> 
> > We don't use sysfs too much these days, can we move the knob to
> > devlink, please? (If we only need an on/off switch generic devlink param
> > should be fine).  
> 
> Thanks. I would study devlink.

I'm not sure how relevant it will be to you but this is the
documentation we have:

https://www.kernel.org/doc/html/latest/networking/devlink/index.html
https://www.kernel.org/doc/html/latest/networking/devlink/devlink-params.html

You'll need to add a generic parameter (define + a short description)
like 325e0d0aa683 ("devlink: Add 'enable_iwarp' generic device param")

In terms of driver changes I think the most relevant example to you
will be:

drivers/net/ethernet/ti/cpsw_new.c

You need to call devlink_alloc(), devlink_register and
devlink_params_register() (and the inverse functions).
