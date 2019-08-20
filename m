From: Gavin Lambert <intel@mirality.co.nz>
Date: Tue, 20 Aug 2019 14:15:02 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <f4a18bf808e6f30e9691e127722f851b@mirality.co.nz>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
 <000661bda5687541e895a949c76712fb@mirality.co.nz>
 <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
 <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
 <f4a18bf808e6f30e9691e127722f851b@mirality.co.nz>
Message-ID: <f6b7b539ece1ba352c60c6dc976a3ce2@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-19 13:02, I wrote:
> On 2019-07-19 12:40, I wrote:
>> FWIW, I added some extra logging around the new code.  I can confirm
>> that it does execute on link regain but doesn't actually enter the
>> loop in my problem case.  The pcim_state is 0x00080083 at the time.
>> So the e1000_phy_hw_reset is never actually called.  If I try changing
>> it to call that unconditionally, then it can't successfully establish
>> a link in the first place.
> 
> I added a call to e1000e_dump at the point of link regain, in hopes
> that it might shed more light.
[register dumps clipped]

Does anyone have any ideas about this?  Either towards further 
investigation or to a possible resolution?

This is at the point of hardware internals now, so I have no idea how to 
proceed in either area.
