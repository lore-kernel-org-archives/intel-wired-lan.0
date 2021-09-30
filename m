From: Switzer, David <david.switzer@intel.com>
Date: Thu, 30 Sep 2021 20:07:54 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix endless loop under
 rtnl
In-Reply-To: <452ff4ddfef7fc8f558a8c8eb7a8050688760e11.1631609537.git.jbenc@redhat.com>
References: <452ff4ddfef7fc8f558a8c8eb7a8050688760e11.1631609537.git.jbenc@redhat.com>
Message-ID: <MW3PR11MB47484B86C8BE138AB4BA229FEBAA9@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jiri
>Benc
>Sent: Tuesday, September 14, 2021 1:55 AM
To: netdev@vger.kernel.org
>Cc: intel-wired-lan at lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net v2] i40e: fix endless loop under rtnl
>
>The loop in i40e_get_capabilities can never end. The problem is that although
>i40e_aq_discover_capabilities returns with an error if there's a firmware
>problem, the returned error is not checked. There is a check for
>pf->hw.aq.asq_last_status but that value is set to I40E_AQ_RC_OK on most
>firmware problems.
>
>When i40e_aq_discover_capabilities encounters a firmware problem, it will
>enocunter the same problem on its next invocation. As the result, the loop
>becomes endless. We hit this with I40E_ERR_ADMIN_QUEUE_TIMEOUT but
>looking at the code, it can happen with a range of other firmware errors.
>
>I don't know what the correct behavior should be: whether the firmware
>should be retried a few times, or whether pf->hw.aq.asq_last_status should
>be always set to the encountered firmware error (but then it would be
>pointless and can be just replaced by the i40e_aq_discover_capabilities return
>value). However, the current behavior with an endless loop under the rtnl
>mutex(!) is unacceptable and Intel has not submitted a fix, although we
>explained the bug to them 7 months ago.
>
>This may not be the best possible fix but it's better than hanging the whole
>system on a firmware bug.
>
>Fixes: 56a62fc86895 ("i40e: init code and hardware support")
>Tested-by: Stefan Assmann <sassmann@redhat.com>
>Signed-off-by: Jiri Benc <jbenc@redhat.com>
Tested-by: Dave Switzer <david.switzer@intel.com>
