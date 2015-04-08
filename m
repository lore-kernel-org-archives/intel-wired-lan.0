From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 07 Apr 2015 18:37:40 -0700
Subject: [Intel-wired-lan] [net-next S3 01/13] i40evf: fix bad
	indentation
In-Reply-To: <1428450773.28000.6.camel@jtkirshe-mobl>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
 <1428450773.28000.6.camel@jtkirshe-mobl>
Message-ID: <55248664.9090905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/07/2015 04:52 PM, Jeff Kirsher wrote:
> On Tue, 2015-04-07 at 19:45 -0400, Catherine Sullivan wrote:
>> From: Mitch Williams <mitch.a.williams@intel.com>
>>
>> Not sure how this slipped through. Cosmetic change only.
>>
>> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
>> Change-ID: Iefec17e6bc14985d8cb7925c0bac770aa37de7c9
>> ---
>>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> Thanks Catherine, I have added your patch to my queue.

When you guys send out these series, and have Jeff just reply to every
patch it quickly bloats a 13 patch series over 26 emails.   Any chance
of getting a 00/XX patch with maybe a simple note such as "i40e
updates", and then just have Jeff reply to that?  Otherwise this is
going to probably just degenerate into noise as all of the patches being
replied to makes this kind of hard to review.

- Alex
