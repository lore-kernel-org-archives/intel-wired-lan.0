From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Thu, 4 Jun 2020 04:10:47 +0000
Subject: [Intel-wired-lan] [next-queue v2] ethernet/intel: Convert
 fallthrough code comments
In-Reply-To: <d74c63e48bbc2f437f7d7aad1c0064dac2a47203.camel@perches.com>
References: <20200604030726.1573257-1-jeffrey.t.kirsher@intel.com>
 <d74c63e48bbc2f437f7d7aad1c0064dac2a47203.camel@perches.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044986E9384@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Wednesday, June 3, 2020 20:16
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [next-queue v2] ethernet/intel: Convert fallthrough code comments
> 
> On Wed, 2020-06-03 at 20:07 -0700, Jeff Kirsher wrote:
> > Convert all the remaining 'fall through" code comments to the newer
> > 'fallthough;' keyword.
> 
> Maybe write it was scripted and
[Kirsher, Jeffrey T] 

Partially scripted, I used your script, but when I did a manual search for ' fall' or ' Fall', I found a few more hits.
But I have no issues with updating the patch description to add your suggestions.  Thanks again for the initial script and patch.

> 
> v2: removed unnecessary fallthrough; after break;

