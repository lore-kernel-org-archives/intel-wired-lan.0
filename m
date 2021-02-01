From: Matt Corallo <linux-wired-list@bluematt.me>
Date: Mon, 1 Feb 2021 15:21:46 -0500
Subject: [Intel-wired-lan] [PATCH net] igb: Enable RSS for Intel I211
 Ethernet Controller
In-Reply-To: <20210201114545.6278ae5c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201221222502.1706-1-nick.lowe@gmail.com>
 <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
 <20210201084747.2cb64c3f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <a7a89e90bf6c3f383fa236b1128db8d012223da0.camel@intel.com>
 <20210201114545.6278ae5c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <69e92a09-d597-2385-2391-fee100464c59@bluematt.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 2/1/21 2:45 PM, Jakub Kicinski wrote:
> Matt, would you mind clarifying if this is indeed a regression for i211?
> 

Admittedly, I didn't go all the way back to test that it is, indeed, a regression. The Fixes commit that it was tagged 
with on Tony's tree was something more recent than initial igb landing (its a refactor of RSS) and there are numerous 
posts online indicating common I211 hardware (eg PCEngines APU2) support RSS and properly load multiple cores, so I 
naively assumed that it is a regression of some form.

Did you test kernels odler than c883de9fd787, Nick?

Given that, and the non-invasive nature of the patch, I figured it was worth trying to land on LTS trees and going ahead 
with it for 5.11, but I don't feel strongly on how it ends up on LTS, it just seems a waste to not land it there.

Matt
