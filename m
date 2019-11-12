From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 12 Nov 2019 11:45:23 -0800
Subject: [Intel-wired-lan] [e1000-patches] [PATCH] igb: read flash with
 iomem=strict
In-Reply-To: <498edf36e634b9590fd7f58fa7febde226bb3e6e.camel@intel.com>
References: <0EF347314CF65544BA015993979A29CDB4ED9024@IRSMSX102.ger.corp.intel.com>
 <498edf36e634b9590fd7f58fa7febde226bb3e6e.camel@intel.com>
Message-ID: <20191112114249.00002280@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 12 Nov 2019 11:05:38 -0800 Jeff wrote:
> On Tue, 2019-11-12 at 13:03 +0000, Loktionov, Aleksandr wrote:
> > When Secure Boot is enabled access to the /dev/mem is forbidden for user-
> > space applications and clients are reporting inability to use tools in
> > Secure Boot Mode. The way to perform NVM update is to use igb driver.
> > Currently 1G Linux Base Driver has API which allows only EEPROM access.
> > There is a need to extend IOCTL API to allow NVM and registers access.
> > These defines are necessary for NVM access functions.
> > 
> > Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> > ---  
> 
> This patch only adds defines and macros which are not being used in the
> driver currently.  It appears you are missing the code to actually use
> these defines.  Your missing the changes that Adam made to igb_ethtool.c,
> which are currently being reviewed internally.
> 
> Since this is an incomplete patch, I will drop it from the queue and will
> await a v2 of the patch that has the complete changes needed in the driver.

Not only that, but this is the same code that was just rejected for
the ice driver. I think we should NOT be trying to push this upstream,
knowing that it will likely be rejected.

