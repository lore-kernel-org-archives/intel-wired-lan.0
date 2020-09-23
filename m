From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 23 Sep 2020 17:02:20 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Power cycle phy on PM resume
In-Reply-To: <AC6D77B8-244D-4816-8FFE-A4480378EC4C@canonical.com>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <17092088-86ff-2d31-b3de-2469419136a3@molgen.mpg.de>
 <AC6D77B8-244D-4816-8FFE-A4480378EC4C@canonical.com>
Message-ID: <79f01082-c9b1-f80a-7af4-b61bdbf40c90@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Kai-Heng,


Am 23.09.20 um 16:46 schrieb Kai-Heng Feng:

>> On Sep 23, 2020, at 21:28, Paul Menzel wrote:

>> Am 23.09.20 um 09:47 schrieb Kai-Heng Feng:
>>> We are seeing the following error after S3 resume:
>>> [  704.746874] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
>>> [  704.844232] e1000e 0000:00:1f.6 eno1: MDI Write did not complete
>>> [  704.902817] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
>>> [  704.903075] e1000e 0000:00:1f.6 eno1: reading PHY page 769 (or 0x6020 shifted) reg 0x17
>>> [  704.903281] e1000e 0000:00:1f.6 eno1: Setting page 0x6020
>>> [  704.903486] e1000e 0000:00:1f.6 eno1: writing PHY page 769 (or 0x6020 shifted) reg 0x17
>>> [  704.943155] e1000e 0000:00:1f.6 eno1: MDI Error
>>> ...
>>> [  705.108161] e1000e 0000:00:1f.6 eno1: Hardware Error
>>> Since we don't know what platform firmware may do to the phy, so let's
>>> power cycle the phy upon system resume to resolve the issue.
>>
>> Is there a bug report or list thread for this issue?
> 
> No. That's why I sent a patch to start discussion :)

Then please add on what systems that is.

>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>   drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index 664e8ccc88d2..c2a87a408102 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -6968,6 +6968,8 @@ static __maybe_unused int e1000e_pm_resume(struct device *dev)
>>>   	    !e1000e_check_me(hw->adapter->pdev->device))
>>>   		e1000e_s0ix_exit_flow(adapter);
>>>   +	e1000_power_down_phy(adapter);
>>> +
>>>   	rc = __e1000_resume(pdev);
>>>   	if (rc)
>>>   		return rc;
>>
>> How much does this increase the resume time?
> 
> I didn't measure it. Because for me it's more important to have a working device.
> 
> Does it have a noticeable impact on your system's resume time?

I am not able to test the patch right now. But resume time is important 
to me. As I do not have the problem, nothing should be changed for my 
system (Dell Latitude E7250).

     00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet 
Connection (3) I218-LM [8086:15a2] (rev 03)


Kind regards,

Paul
