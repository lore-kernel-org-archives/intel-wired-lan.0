From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 Mar 2021 12:37:21 -0800
Subject: [Intel-wired-lan] [RFC PATCH 01/10] ethtool: Add common
 function for filling out strings
In-Reply-To: <20210310180807.5fb1752d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
 <161542651749.13546.3959589547085613076.stgit@localhost.localdomain>
 <20210310180807.5fb1752d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20210311123721.00005913@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski wrote:

> On Wed, 10 Mar 2021 17:35:17 -0800 Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> > +/**
> > + * ethtool_gsprintf - Write formatted string to ethtool string data
> > + * @data: Pointer to start of string to update
> > + * @fmt: Format of string to write
> > + *
> > + * Write formatted string to data. Update data to point at start of
> > + * next string.
> > + */
> > +extern __printf(2, 3) void ethtool_gsprintf(u8 **data, const char *fmt, ...);
> 
> I'd drop the 'g' TBH, it seems to have made its way from the ethtool
> command ('gstrings') to various places but without the 'string' after
> it - it becomes less and less meaningful. Just ethtool_sprintf() would
> be fine IMHO.
> 
> Other than that there is a minor rev xmas tree violation in patch 2 :)


I agree with Jakub, and I really like this series, it's a good clean up.

I'll be glad to add a reviewed by tag to v2.

