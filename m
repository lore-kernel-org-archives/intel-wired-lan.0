From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Mon, 4 Oct 2021 17:21:31 -0700 (PDT)
Subject: [Intel-wired-lan] [EXT] Re: Intel I350 regression 5.10 -> 5.14
 ("The NVM Checksum Is Not Valid") [8086:1521]
In-Reply-To: <1763660.QCnGb9OGeP@pinacolada>
References: <1823864.tdWV9SEqCh@kailua>
 <20211004074814.5900791a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7064659e-fe97-f222-5176-844569fb5281@twofifty.com>
 <1763660.QCnGb9OGeP@pinacolada>
Message-ID: <caf054b-c155-7614-5e97-e5ed34bf4eee@twofifty.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 5 Oct 2021, Andreas K. Huettel wrote:

>>>>
>>>> Any advice on how to proceed? Willing to test patches and provide
>>>> additional debug info.
>> Sorry to reply from a non-Intel account. I would suggest first
>> contacting Dell, and then contacting DeLock. This sounds like an
>> issue with motherboard firmware and most of what I can help with
>> would be with the driver. I think the issues are probably before
>> things get to the driver.
>
> Ouch. OK. Can you think of any temporary workaround?
>
> (Other than downgrading to 5.10 again, which I can't since it fails
> at the graphics (i915) modesetting...)

This is completely unofficial because I don't really work on client
systems, but I'd try different NICs, different slots, and the BIOS
settings.

You also might try support at intel.com because they're much more used to
client system support.

Todd Fujinaka todd.fujinaka at intel.com
