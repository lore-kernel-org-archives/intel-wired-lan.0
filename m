From: David Miller <davem@davemloft.net>
Date: Thu, 05 Nov 2015 13:31:31 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH v6] i40e: Look up MAC address in Open
	Firmware or IDPROM
In-Reply-To: <CAHp75VfiV6DVb-2piCxmEWFP4Gi-+n0qNhhscvd=UsqXrivVYg@mail.gmail.com>
References: <20151105.103126.148818796422971143.davem@davemloft.net>
 <20151105.110506.1901401372160830603.davem@davemloft.net>
 <CAHp75VfiV6DVb-2piCxmEWFP4Gi-+n0qNhhscvd=UsqXrivVYg@mail.gmail.com>
Message-ID: <20151105.133131.1900833527415923596.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2015 20:13:21 +0200

> What about
> 
> if (!addr)
>  return -ENODATA;

I totally disagree.  of_get_phy_mode() and other similar attribute
probing mechanisms use -ENODEV.
