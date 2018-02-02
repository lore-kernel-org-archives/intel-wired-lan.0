From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Fri, 2 Feb 2018 21:08:25 +0000
Subject: [Intel-wired-lan] Possible read-modify-write bug in ixgbe x550
 phy setup
In-Reply-To: <87618083B2453E4A8714035B62D67992CC0DE252@FMSMSX105.amr.corp.intel.com>
References: <59b6e262-8027-675c-f75e-3a95d3a97e4f@oracle.com>
 <87618083B2453E4A8714035B62D67992CC0DE147@FMSMSX105.amr.corp.intel.com>
 <4d969de9-ad06-e696-21c1-74be9e03d2f7@oracle.com>
 <87618083B2453E4A8714035B62D67992CC0DE252@FMSMSX105.amr.corp.intel.com>
Message-ID: <87618083B2453E4A8714035B62D67992CC0DE506@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>Behalf Of Tantilov, Emil S
>Sent: Thursday, February 01, 2018 4:58 PM
>To: Shannon Nelson <shannon.nelson@oracle.com>
>Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
>Subject: Re: [Intel-wired-lan] Possible read-modify-write bug in ixgbe
>x550 phy setup
>
>>-----Original Message-----
>>From: Shannon Nelson [mailto:shannon.nelson at oracle.com]
>>Sent: Thursday, February 01, 2018 4:44 PM
>>To: Tantilov, Emil S <emil.s.tantilov@intel.com>
>>Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
>>Subject: Re: [Intel-wired-lan] Possible read-modify-write bug in ixgbe
>>x550 phy setup
>>
>>On 2/1/2018 4:34 PM, Tantilov, Emil S wrote:
>>>> -----Original Message-----
>>>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>>>> Behalf Of Shannon Nelson
>>>> Sent: Thursday, February 01, 2018 3:46 PM
>>>> To: Tantilov, Emil S <emil.s.tantilov@intel.com>
>>>> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
>>>> Subject: [Intel-wired-lan] Possible read-modify-write bug in ixgbe
>>x550
>>>> phy setup
>>>>
>>>> Hi Emil,
>>>>
>>>> I was looking through a set of ixgbe patches and came across this
>>commit
>>>>
>>>>      commit 410a494902777c11f95031d9ed757d7f8f09c5c6
>>>>      ixgbe: add write flush when configuring CS4223/7
>>>>
>>>> and am wondering about the setting of reg_phy_ext in the middle of
>>>> ixgbe_setup_mac_link_sfp_x550a().  It looks like it is read from the
>>>> PHY, modified to remove the CX1 and SR mode bits, but then those
>bits
>>>> are overwritten in the "if (setup_linear)" block immediately
>>following,
>>>> and that is what gets written back out.
>>>
>>> Hi Shannon,
>>>
>>> This is pretty standard clear before set, so you're right that it
>>would
>>> make more sense to have |= rather than =.
>>>
>>> Are you seeing an issue, or did you catch this via code inspection?
>>
>>Purely a code inspection, I saw this while looking at something else.
>>
>>sln
>
>Thanks for letting us know. I will do some more testing with the actual
>HW before changing the code.

Just FYI - we looked at the reads and confirmed that there is no functional
bug in the code because as it happens the CX1/SR bits is the only bits that
are read and set and as such we don't lose any data. This of course means
that the read is not needed and we'll just remove it.

Thanks,
Emil
