From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 1 Feb 2018 16:43:51 -0800
Subject: [Intel-wired-lan] Possible read-modify-write bug in ixgbe x550
 phy setup
In-Reply-To: <87618083B2453E4A8714035B62D67992CC0DE147@FMSMSX105.amr.corp.intel.com>
References: <59b6e262-8027-675c-f75e-3a95d3a97e4f@oracle.com>
 <87618083B2453E4A8714035B62D67992CC0DE147@FMSMSX105.amr.corp.intel.com>
Message-ID: <4d969de9-ad06-e696-21c1-74be9e03d2f7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/1/2018 4:34 PM, Tantilov, Emil S wrote:
>> -----Original Message-----
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>> Behalf Of Shannon Nelson
>> Sent: Thursday, February 01, 2018 3:46 PM
>> To: Tantilov, Emil S <emil.s.tantilov@intel.com>
>> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
>> Subject: [Intel-wired-lan] Possible read-modify-write bug in ixgbe x550
>> phy setup
>>
>> Hi Emil,
>>
>> I was looking through a set of ixgbe patches and came across this commit
>>
>>      commit 410a494902777c11f95031d9ed757d7f8f09c5c6
>>      ixgbe: add write flush when configuring CS4223/7
>>
>> and am wondering about the setting of reg_phy_ext in the middle of
>> ixgbe_setup_mac_link_sfp_x550a().  It looks like it is read from the
>> PHY, modified to remove the CX1 and SR mode bits, but then those bits
>> are overwritten in the "if (setup_linear)" block immediately following,
>> and that is what gets written back out.
> 
> Hi Shannon,
> 
> This is pretty standard clear before set, so you're right that it would
> make more sense to have |= rather than =.
> 
> Are you seeing an issue, or did you catch this via code inspection?

Purely a code inspection, I saw this while looking at something else.

sln

