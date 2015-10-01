From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 01 Oct 2015 22:01:57 +0200
Subject: [Intel-wired-lan] [PATCH 03/12] net: igb: avoid using timespec
In-Reply-To: <20151001191745.GC1872@localhost.localdomain>
References: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
 <1443612402-3000775-4-git-send-email-arnd@arndb.de>
 <20151001191745.GC1872@localhost.localdomain>
Message-ID: <1803983.ImzkvzgWES@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thursday 01 October 2015 21:17:45 Richard Cochran wrote:
> On Wed, Sep 30, 2015 at 01:26:33PM +0200, Arnd Bergmann wrote:
> > diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > index 5982f28d521a..c44df87c38de 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> > @@ -143,7 +143,7 @@ static void igb_ptp_write_i210(struct igb_adapter *adapter,
> >        * sub-nanosecond resolution.
> >        */
> >       wr32(E1000_SYSTIML, ts->tv_nsec);
> > -     wr32(E1000_SYSTIMH, ts->tv_sec);
> > +     wr32(E1000_SYSTIMH, (u32)ts->tv_sec);
> 
> This cast is unnecessary, because wr32 is writel, and that parameter
> is a u32.

I tried to use this pattern whenever I convert the 64-bit 'long long'
tv_sec member of 'struct timespec64' into a 32-bit number, to annotate
the loss of range.

I have thought about defining separate helpers like this

/* result will overflow in 2038 for real time */
static inline s32 time64_to_s32_y2038(time64_t time)
{
	return time;
}

/* result will overflow in 2106 for real time */
static inline u32 time64_to_u32_y2106(time64_t time)
{
	return time;
}

/* monotonic times can safely be represented as 32 bit */
static inline s32 time64_to_s32_monotonic(time64_t time)
{
	return time;
}

This would make it even more explicit, but my fear was that I was
adding too much complexity like that.

	Arnd
