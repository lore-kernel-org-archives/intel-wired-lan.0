From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 3 Nov 2020 10:39:40 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] ethernet: igb: e1000_phy: Check
 for ops.force_speed_duplex existence
In-Reply-To: <36ce1f2e-843c-4995-8bb2-2c2676f01b9d@molgen.mpg.de>
References: <20201102231307.13021-1-pmenzel@molgen.mpg.de>
 <20201102231307.13021-3-pmenzel@molgen.mpg.de>
 <20201102161943.343586b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <36ce1f2e-843c-4995-8bb2-2c2676f01b9d@molgen.mpg.de>
Message-ID: <20201103103940.2ed27fa2@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 3 Nov 2020 08:35:09 +0100 Paul Menzel wrote:
> According to *Developer's Certificate of Origin 1.1* [3], it?s my 
> understanding, that it is *not* required. The items (a), (b), and (c) 
> are connected by an *or*.
> 
> >         (b) The contribution is based upon previous work that, to the best
> >             of my knowledge, is covered under an appropriate open source
> >             license and I have the right under that license to submit that
> >             work with modifications, whether created in whole or in part 
> >             by me, under the same open source license (unless I am
> >             permitted to submit under a different license), as indicated
> >             in the file; or  

Ack, but then you need to put yourself as the author, because it's
you certifying that the code falls under (b).

At least that's my understanding.
