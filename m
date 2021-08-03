From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 2 Aug 2021 17:03:04 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CO1PR11MB508917A17F68DD927CD26A82D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
 <CO1PR11MB508917A17F68DD927CD26A82D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <20210803000304.GA19119@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 02, 2021 at 11:45:09PM +0000, Keller, Jacob E wrote:
> Ok, so basically: if any driver that needs PTP core is on, PTP core is on, with no way to disable it.

Right.  Some MAC drivers keep the PTP stuff under a second Kconfig option.

IIRC, we (davem and netdev) decided not to do that going forwards.  If
a MAC has PTP features, then users will sure want it enabled.

So, let the MACs use "depends" or "select" PTP core.  I guess that
"select" is more user friendly.

And Posix timers: never disable this.  After all, who wants an
embedded system without timer_create()?  Seriously?

Thanks,
Richard


