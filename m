From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 14 Sep 2021 16:37:55 -0700
Subject: [Intel-wired-lan] [PATCH net] i40e: fix endless loop under rtnl
In-Reply-To: <4d94f7fbd9dd6476c5adc8967f3db84bc9204f47.1630319620.git.jbenc@redhat.com>
References: <4d94f7fbd9dd6476c5adc8967f3db84bc9204f47.1630319620.git.jbenc@redhat.com>
Message-ID: <b94eb5b1-04b7-a1ba-3040-a8f35d40f426@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

+intel-wired-lan list

On 8/30/2021 3:34 AM, Jiri Benc wrote:
> The loop in i40e_get_capabilities can never end. The problem is that
> although i40e_aq_discover_capabilities returns with an error if there's
> a firmware problem, the returned error is not checked. There is a check for
> pf->hw.aq.asq_last_status but that value is set to I40E_AQ_RC_OK on most
> firmware problems.
> 
> When i40e_aq_discover_capabilities encounters a firmware problem, it will
> enocunter the same problem on its next invocation. As the result, the loop
encounter

> becomes endless. We hit this with I40E_ERR_ADMIN_QUEUE_TIMEOUT but looking
> at the code, it can happen with a range of other firmware errors.
> 
> I don't know what the correct behavior should be: whether the firmware
> should be retried a few times, or whether pf->hw.aq.asq_last_status should
> be always set to the encountered firmware error (but then it would be
> pointless and can be just replaced by the i40e_aq_discover_capabilities
> return value).

If the firmware doesn't reply we have a lot of problems.

> However, the current behavior with an endless loop under the
> rtnl mutex(!) is unacceptable and Intel has not submitted a fix, although we
> explained the bug to them 7 months ago.

That's really frustrating, sorry! We are actively working to do better
by working with you more closely. This one must have slipped through the
cracks.


> This may not be the best possible fix but it's better than hanging the whole
> system on a firmware bug.
> 

The fix seems fine to me on initial review.
you can add my
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

but...
Missing Fixes: tag?

> Tested-by: Stefan Assmann <sassmann@redhat.com>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 1d1f52756a93..772dd05a0ae8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -10110,7 +10110,7 @@ static int i40e_get_capabilities(struct i40e_pf *pf,
>  		if (pf->hw.aq.asq_last_status == I40E_AQ_RC_ENOMEM) {
>  			/* retry with a larger buffer */
>  			buf_len = data_size;
> -		} else if (pf->hw.aq.asq_last_status != I40E_AQ_RC_OK) {
> +		} else if (pf->hw.aq.asq_last_status != I40E_AQ_RC_OK || err) {
>  			dev_info(&pf->pdev->dev,
>  				 "capability discovery failed, err %s aq_err %s\n",
>  				 i40e_stat_str(&pf->hw, err),
> 

