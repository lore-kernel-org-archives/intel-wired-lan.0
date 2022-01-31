From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 31 Jan 2022 15:19:58 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220131151315.4ec5f2d3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220131172450.4905-1-saeed@kernel.org>
 <20220131095905.08722670@hermes.local>
 <CAMuHMdU17cBzivFm9q-VwF9EG5MX75Qct=is=F2h+Kc+VddZ4g@mail.gmail.com>
 <20220131183540.6ekn3z7tudy5ocdl@sx1>
 <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
 <20220131121027.4fe3e8dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7dc930c6-4ffc-0dd0-8385-d7956e7d16ff@gmail.com>
 <20220131151315.4ec5f2d3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <dd1497ca-b1da-311a-e5fc-7c7265eb3ddf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/31/2022 3:13 PM, Jakub Kicinski wrote:
> On Mon, 31 Jan 2022 15:06:01 -0800 Florian Fainelli wrote:
>>>> Right, but once you start hiding NET_VENDOR_DRIVER_XYZ under a
>>>> NET_VENDOR_XYZ Kconfig symbol dependency, if NET_VENDOR_XYZ is not set
>>>> to Y, then you have no way to select NET_VENDOR_DRIVER_XYZ and so your
>>>> old defconfig breaks.
>>>
>>> To be clear do we actually care about *old* configs or *def* configs?
>>
>> I think we care about oldconfig but maybe less so about defconfigs which
>> are in tree and can be updated.
> 
> The oldconfigs would have to not be updated on any intervening kernel
> in the last 10+ years to break, right? Or is there another way that an
> oldconfig would not have the vendor config set to y at this point?

That sounds very unrealistic, so yes, I don't think at this point that 
would happen. Even if you had your 15 year old .config file and ran make 
oldconfig today, you would have some work to do to make sure it still 
runs on your hardware.
-- 
Florian
