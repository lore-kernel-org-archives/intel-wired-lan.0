From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 16 Feb 2016 17:24:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next V2 4/6] igb:
	call	ndo_stop()	instead of dev_close() when running offline selftest
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E89BFE@ORSMSX101.amr.corp.intel.com>
References: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>
 <1454487652-1545-5-git-send-email-sassmann@kpanic.de>
 <309B89C4C689E141A5FF6A0C5FB2118B81E89BFE@ORSMSX101.amr.corp.intel.com>
Message-ID: <CBCD8DCD-53A4-4628-A760-592A6CE15A73@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Aaron F <aaron.f.brown@intel.com> wrote:

>> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on  
>> behalf of Stefan Assmann [sassmann at kpanic.de]
>> Sent: Wednesday, February 03, 2016 12:20 AM
>> To: intel-wired-lan at lists.osuosl.org
>> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
>> Subject: [Intel-wired-lan] [PATCH net-next V2 4/6] igb: call ndo_stop()  
>> instead of dev_close() when running offline selftest
>>
>> Calling dev_close() causes IFF_UP to be cleared which will remove the
>> interfaces routes and some addresses. That's probably not what the user
>> intended when running the offline selftest. Besides this does not happen
>> if the interface is brought down before the test, so the current
>> behaviour is inconsistent.
>> Instead call the net_device_ops ndo_stop function directly and avoid
>> touching IFF_UP at all.
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  drivers/net/ethernet/intel/igb/igb.h         | 2 ++
>>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>>  drivers/net/ethernet/intel/igb/igb_main.c    | 8 ++++----
>>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> Checkpatch warns that externs should be avoided in .c files, but they  
> pre-existed and are just being flagged due to the name changing, so...
>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Again, the prototypes in the .c should be deleted in favor of the ones that  
were added to the .h file.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160216/c30b8ef1/attachment.asc>
