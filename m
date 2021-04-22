From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 22 Apr 2021 18:16:24 +0000
Subject: [Intel-wired-lan] [PATCH] ice: set the value of global config
 lock timeout longer
In-Reply-To: <fca32ba9-ad20-0994-de7c-b3bf8425a07b@windriver.com>
References: <20210419093106.6487-1-liwei.song@windriver.com>
 <7d85412de58342e4469efdfdc6196925ce770993.camel@intel.com>
 <fca32ba9-ad20-0994-de7c-b3bf8425a07b@windriver.com>
Message-ID: <8d6eb1116cac38c764fce754a9fa272ac4509bbb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-04-21 at 10:29 +0800, Liwei Song wrote:
> 
> On 4/21/21 06:48, Nguyen, Anthony L wrote:
> > On Mon, 2021-04-19 at 17:31 +0800, Liwei Song wrote:
> > > It may need hold Global Config Lock a longer time when download
> > > DDP
> > > package file, extend the timeout value to 5000ms to ensure that
> > > download can be finished before other AQ command got time to run,
> > > this will fix the issue below when probe the device, 5000ms is a
> > > test
> > > value that work with both Backplane and BreakoutCable NVM image:
> > > 
> > > ice 0000:f4:00.0: VSI 12 failed lan queue config, error
> > > ICE_ERR_CFG
> > > ice 0000:f4:00.0: Failed to delete VSI 12 in FW - error:
> > > ICE_ERR_AQ_TIMEOUT
> > > ice 0000:f4:00.0: probe failed due to setup PF switch: -12
> > > ice: probe of 0000:f4:00.0 failed with error -12
> > 
> > Hi Liwei,
> > 
> > We haven't encountered this issue before. Can you provide some more
> > info on your setup or how you're coming across this issue?
> > 
> > Perhaps, lspci output and some more of the dmesg log? We'd like to
> > try
> > to reproduce this so we can invesitgate it further.
> 
> Hi Tony,
> 
> My board is Idaville ICE-D platform, it can be reproduced when
> there is no QSFP Transceiver Module setup on it, it is not
> happened on each "modprobe ice", about 1/8 rate to got that
> error message when I loop run "modprobe -r ice && modprobe ice".
> the port type is Backplane, and I haven't reproduce
> it with Breakout mode. 

Hi Liwei, 

Thanks for the additional information. I've provided this to our
validation team and asked they try to reproduce so we can look into it further.

Thanks,
Tony
