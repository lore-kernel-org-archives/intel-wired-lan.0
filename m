From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 16 Feb 2016 20:02:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next V2 5/6] e1000: call
 ndo_stop()	instead of dev_close() when running offline selftest
In-Reply-To: <D922F8B9-0F84-45C5-8BD6-6D57ABFAF01D@intel.com>
References: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>
 <1454487652-1545-6-git-send-email-sassmann@kpanic.de>
 <309B89C4C689E141A5FF6A0C5FB2118B81E89BE2@ORSMSX101.amr.corp.intel.com>,
 <D922F8B9-0F84-45C5-8BD6-6D57ABFAF01D@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E8B086@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Rustad, Mark D
> Sent: Tuesday, February 16, 2016 9:23 AM
> To: Stefan Assmann
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; davem at davemloft.net; Brown, Aaron F
> Subject: Re: [Intel-wired-lan] [PATCH net-next V2 5/6] e1000: call ndo_stop()   instead of dev_close() when running offline selftest
> 
> > Checkpatch warns that externs should be avoided in .c files, but they
> > pre-existed and are just being flagged due to the name changing, so...
> >
> > Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> 
> Actually, it is the forward declarations in the .c that should be deleted.
> The prototypes should only exist in the .h file.

Thanks Mark,  I completely missed that the patch added it to both files, too busy reviving older hardware to extend to run the diags against a larger set of parts I guess :")
