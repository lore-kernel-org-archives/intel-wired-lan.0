From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 22 Mar 2022 18:12:08 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: use min_t() to make code
 cleaner in ice_gnss
In-Reply-To: <20220322175038.2691665-1-alexandr.lobakin@intel.com>
References: <20220321135947.378250-1-wanjiabing@vivo.com>
 <f888e3cf09944f9aa63532c9f59e69fb@AcuMS.aculab.com>
 <20220322175038.2691665-1-alexandr.lobakin@intel.com>
Message-ID: <af3fa59809654c9b9939f1e0bd8ca76b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Lobakin
> Sent: 22 March 2022 17:51
> From: David Laight <David.Laight@ACULAB.COM>
> Date: Mon, 21 Mar 2022 16:02:20 +0000
> 
> > From: Wan Jiabing
> > > Sent: 21 March 2022 14:00
> > >
> > > Fix the following coccicheck warning:
> > > ./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity for min()
> > >
> > > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > > ---
> > > Changelog:
> > > v2:
> > > - Use typeof(bytes_left) instead of u8.
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_gnss.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > > index 35579cf4283f..57586a2e6dec 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> > > @@ -76,8 +76,7 @@ static void ice_gnss_read(struct kthread_work *work)
> > >  	for (i = 0; i < data_len; i += bytes_read) {
> > >  		u16 bytes_left = data_len - i;
> >
> > Oh FFS why is that u16?
> > Don't do arithmetic on anything smaller than 'int'
> 
> Any reasoning? I don't say it's good or bad, just want to hear your
> arguments (disasms, perf and object code measurements) etc.

Look at the object code on anything except x86.
The compiler has to add instruction to mask the value
(which is in a full sized register) down to 16 bits
after every arithmetic operation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

