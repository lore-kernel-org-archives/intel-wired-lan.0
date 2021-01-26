From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 26 Jan 2021 21:31:07 +0000
Subject: [Intel-wired-lan] igc: fix link speed advertising
In-Reply-To: <20210126120055.001934db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201117195040.178651-1-vinschen@redhat.com>
 <20210126103037.GH4393@calimero.vinschen.de>
 <20210126120055.001934db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <b05eb6d7ac2df2aa6db81ca2a51c519daed7ed52.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-01-26 at 12:00 -0800, Jakub Kicinski wrote:
> On Tue, 26 Jan 2021 11:30:37 +0100 Corinna Vinschen wrote:
> > Ping?
> > 
> > It looks like this patch got lost somehow.  Without this patch,
> > setting link speed advertising is broken.
> 
> Adding Intel maintainers.

I talked to the team and they won't be able to get to testing this
patch soon. We have reviewed the code and everything looks correct so
I'll submit it in my pull request today.

Thanks,
Tony
