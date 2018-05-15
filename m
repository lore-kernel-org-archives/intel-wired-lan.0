From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 15 May 2018 08:21:03 -0400
Subject: [Intel-wired-lan] [PATCH v4 1/1] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180515073744.GA28338@kroah.com>
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
 <20180514194254.14748-2-pasha.tatashin@oracle.com>
 <20180515073744.GA28338@kroah.com>
Message-ID: <CAGM2reYnZ6q-2XCJ+7=6g+8OPvujCwnhXX7BMQbOLemSTpJY+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Greg,

> Can you refactor this to be at least 2 patches?  One that moves code
> around to comon functions to make the second patch, that adds the new
> functionality, easier to review and understand?

Yes, I will split the patch into a two-three patches.


> And I echo the "don't use kerneldoc for static functions" review
> comment, that's not needed at all.

It was my mistake, I did not realize they were kerneldoc, I simply tried to
follow the code style of this file :) I will modify comments not to be
kerneldoc.

Thank you,
Pavel
