From: Jonathan Toppins <jtoppins@cumulusnetworks.com>
Date: Tue, 05 May 2015 15:31:03 -0400
Subject: [Intel-wired-lan] [PATCH v1 net-next 2/2] igb: support
	SIOCSMIIREG
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B78DBE9D2@ORSMSX101.amr.corp.intel.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1429302240-654-2-git-send-email-jtoppins@cumulusnetworks.com>
 <309B89C4C689E141A5FF6A0C5FB2118B78DBE9D2@ORSMSX101.amr.corp.intel.com>
Message-ID: <55491A77.70302@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/5/15 1:25 PM, Brown, Aaron F wrote:
>> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
>> On Behalf Of Jonathan Toppins
>> Sent: Friday, April 17, 2015 1:24 PM
>> To: Kirsher, Jeffrey T
>> Cc: Brandeburg, Jesse; Nelson, Shannon; Wyborny, Carolyn; Skidmore, Donald
>> C; Vick, Matthew; Ronciak, John; Williams, Mitch A; intel-wired-
>> lan at lists.osuosl.org; netdev at vger.kernel.org; gospo at cumulusnetworks.com;
>> shm at cumulusnetworks.com; Alan Liebthal
>> Subject: [PATCH v1 net-next 2/2] igb: support SIOCSMIIREG
>>
>> From: Alan Liebthal <alanl@cumulusnetworks.com>
>>
>> Support setting the MII register via SIOCSMIIREG.
>>
>> Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
>> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_main.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
>
Thanks Aaron, appreciate the testing.
