From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 13 Oct 2015 17:41:25 +0000
Subject: [Intel-wired-lan] [next-queue v2 3/6] i40e: clean up the entire
 function exit path
In-Reply-To: <20151013095926.000012e2@unknown>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-3-git-send-email-sakiwit@gmail.com>
 <20151013095926.000012e2@unknown>
Message-ID: <87618083B2453E4A8714035B62D67992504BAEAC@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Jesse Brandeburg
>Sent: Tuesday, October 13, 2015 9:59 AM
>To: J?an Sacren
>Cc: intel-wired-lan at lists.osuosl.org
>Subject: Re: [Intel-wired-lan] [next-queue v2 3/6] i40e: clean up the
>entire function exit path
>
>On Tue, 13 Oct 2015 01:06:29 -0600
>J?an Sacren <sakiwit@gmail.com> wrote:
>
>> From: Jean Sacren <sakiwit@gmail.com>
>>
>> In i40e_tsyn(), by using a label of 'no_timestamp', we will be able to
>> clearly denote a slew of circumstances that return with 0, which is much
>> better as a default exit than the one that returns with 1.
>
>What's the motivation for making this change?  Just code clean up?
>
>BTW thanks for the patches, I realize you spent a good amount of time
>finding the issues/reviewing code.
>
>>
>> With the above change, in the last check, we will be able to spare the
>> 'else' branch. Further, the whole branch for returning 1 shall be put
>> together for clarity.
>
>Does sparing the "else branch" help anything?  I'm not quite sure what
>the point of this change is beyond just code churn.  If it is deemed
>better this way by someone else, then fine, and I'll ACK it, but the
>change itself really seems unnecessary.

Actually this patch goes against guidelines of the coding style:
https://www.kernel.org/doc/Documentation/CodingStyle

Specifically the following paragraph:

The goto statement comes in handy when a function exits from multiple
locations and some common work such as cleanup has to be done.  If there is no
cleanup needed then just return directly.

So this is a clear NACK IMHO.

Thanks,
Emil

