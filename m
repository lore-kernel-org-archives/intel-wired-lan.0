From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 7 Sep 2021 23:20:25 +0000
Subject: [Intel-wired-lan] Potential oob access in e100.c:get_regs(_len)
In-Reply-To: <d656c5d2-bdb6-5b05-1c4a-bcf6ec9194df@gmail.com>
References: <1f52bd29-43e7-0639-57cf-abfb7dc9804b@sect.tu-berlin.de>
 <c2ca99a7-9389-de32-bf2d-5128158a094a@intel.com>
 <d656c5d2-bdb6-5b05-1c4a-bcf6ec9194df@gmail.com>
Message-ID: <CO1PR11MB5089966E71DCA79851929DCCD6D39@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Felicitas Hetzelt <felicitashetzelt@gmail.com>
> Sent: Monday, September 06, 2021 5:05 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] Potential oob access in e100.c:get_regs(_len)
> 
> Hi,
> > Are you seeing the same thing I am?
> 
> Seems to me like you are right! I wonder why this was never caught though.
> 
> Also, KASAN did trigger on this path which I guess is an indication that
> there in fact is a problem.
> 
> 
> Regards,
> 
> Felicitas

I am guessing it is because it's e100. Not heavily used and you'd have to specifically run the register dump ethtool interface.

I can create a patch for this, I think it's worth fixing even if it's e100 because it would cause a kernel panic.

Thanks,
Jake
