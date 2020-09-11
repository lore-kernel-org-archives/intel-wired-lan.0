From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 11 Sep 2020 16:18:05 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 06/11]
 drivers/net/ethernet: clean up unused assignments
In-Reply-To: <e1cf9542-4e3b-a666-7861-47b069b3a606@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-7-jesse.brandeburg@intel.com>
 <e1cf9542-4e3b-a666-7861-47b069b3a606@intel.com>
Message-ID: <20200911161805.00005aa1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jacob Keller wrote:
 		err = -EBUSY;
> > diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > index 8e0ed01e7f03..737ae69eec6e 100644
> > --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> > @@ -1,4 +1,4 @@
> > -/**********************************************************************
> > +/*
> 
> I suspect this was meant to go into the kdoc patch instead?

Actually it shouldn't be there at all, but it's fixed, thanks!
