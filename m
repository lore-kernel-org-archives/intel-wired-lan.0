From: Joe Perches <joe@perches.com>
Date: Wed, 02 Dec 2015 02:12:29 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix i40e_print_features() VEB
	mode output
In-Reply-To: <1449050215.3224.29.camel@intel.com>
References: <1448475679-57194-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1448475679-57194-5-git-send-email-jeffrey.t.kirsher@intel.com>
 <5655FD72.70902@cogentembedded.com> <1448476535.3021.5.camel@intel.com>
 <1448480194.20113.48.camel@perches.com>
 <1449002936.1593.10.camel@perches.com> <1449041100.3224.17.camel@intel.com>
 <1449045535.3716.10.camel@perches.com> <1449050215.3224.29.camel@intel.com>
Message-ID: <1449051149.3716.20.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-12-02 at 01:56 -0800, Jeff Kirsher wrote:
> On Wed, 2015-12-02 at 00:38 -0800, Joe Perches wrote:
> > Commit 7fd89545f337 ("i40e: remove BUG_ON from feature string
> > building")
> > added defective output when I40E_FLAG_VEB_MODE_ENABLED was set in
> > function i40e_print_features.
> > 
> > Fix it.
> > 
> > Miscellanea:
> > 
> > o Remove unnecessary string variable
> > o Add space before not after fixed strings
> > o Use kmalloc not kzalloc
> > o Don't initialize i to 0, use result of first snprintf
> > 
> > Noticed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Don't you mean Reported-by? ?I am not aware of Noticed-by as being a
> recognized signature.

At least for the get_maintainer script, "<anything>-by:" is a signature


