From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 15 May 2018 19:37:30 +0200
Subject: [Intel-wired-lan] [PATCH] ethtool: stop the line wrapping
 madness
In-Reply-To: <20180515173208.20352-1-mitch.a.williams@intel.com>
References: <20180515173208.20352-1-mitch.a.williams@intel.com>
Message-ID: <ab0e04cf-e3e0-ed15-900c-5d1a3eab4f1c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Mitch,


On 05/15/18 19:32, Mitch Williams wrote:
> Folks, we have a hard limit of 80 characters per line in the kernel,
> mostly due to Linus' insistence on printing out each release on greenbar
> with his Decwriter. So why do we have function and macro names that are
> over 30 characters long? Add a tab or two and a few parameters and boom!
> you're wrapping lines.
> 
> This patch is a search-n-replace of the newly-added ethtool link
> settings API with shorter names. In general, I replaced 'ksettings' with
> 'ks' and elided some unnecessary verbiage. In nearly every instance I
> unwrapped lines and made the code easier to read, especially on a VT102.

Nice, let?s see what the others think.

> In the case of the Amazon Ethernet driver, I found a bug where they were
> setting bits in the 'settings' field twice. Almost certainly this
> was supposed to set bits in the 'advertising' field instead. So I fixed
> it.

Please split this out into a separate patch.

[?]


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180515/5b84eeb6/attachment.p7s>
