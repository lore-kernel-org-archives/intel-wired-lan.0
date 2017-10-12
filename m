From: Henrik Austad <henrik@austad.us>
Date: Thu, 12 Oct 2017 10:04:12 +0200
Subject: [Intel-wired-lan] [next-queue PATCH v6 4/5] net/sched: Add
 support for HW offloading for CBS
In-Reply-To: <20171012005449.26533-5-vinicius.gomes@intel.com>
References: <20171012005449.26533-1-vinicius.gomes@intel.com>
 <20171012005449.26533-5-vinicius.gomes@intel.com>
Message-ID: <20171012080412.GB29396@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 11, 2017 at 05:54:48PM -0700, Vinicius Costa Gomes wrote:
> This adds support for offloading the CBS algorithm to the controller,
> if supported. Drivers wanting to support CBS offload must implement
> the .ndo_setup_tc callback and handle the TC_SETUP_CBS (introduced
> here) type.

This also answered my question in the previous patch (as to how hw 
offloading can be enabled).

/me goes off to test the series
Looking good so far!

-Henrik
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171012/1eed015e/attachment.asc>
