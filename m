From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Apr 2016 22:16:25 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: don't modify SYSTIM
 registers during SIOCSHWTSTAMP ioctl
In-Reply-To: <20160415220913.GA28644@hobbes.lan20.walshnetwork.net>
References: <20160415213655.28072-1-jacob.e.keller@intel.com>
 <20160415220913.GA28644@hobbes.lan20.walshnetwork.net>
Message-ID: <1460758585.13811.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-15 at 18:09 -0400, Brian Walsh wrote:
> On Fri, Apr 15, 2016 at 02:36:55PM -0700, Jacob Keller wrote:
> > 
> > +
> > +	if (adapter->ptp_clock_info) {
> > +		/* restore the previous ptp frequency delta */
> > +		ret_val = adapter-
> > >ptp_clock_info.adjfreq(&adapter->ptp_clock_info,
> > +							??adapter-
> > >ptp_delta);
> > +		if (ret_val)
> > +			dev_warn(&adapter->pdev->dev,
> > +				?"Failed to restore TIMINCA clock
> > rate delta: %d\n",
> > +				?ret_val);
> > +	else {
> > +		ret_val = e1000e_get_base_timinca(adapter,
> > &timinca);
> > +		if (ret_val)
> > +			dev_warn(&adapter->pdev->dev,
> > +				?"Failed to set default TIMINCA
> > clock rate: %d\n",
> > +				?ret_val);
> > +		else
> > +			ew32(TIMINCA, timinca);
> > +	}
> Can't do a boolean check on a struct ptp_clock_info.
> 
> Testing the patch without the handle NULL ptp_clock_info change.
> 

Oops you're right it's not a pointer... Hmm I was thinking of
ptp_clock. I'll think that through a bit more.

Thanks,
Jake
