From: Tobin C. Harding <me@tobin.cc>
Date: Mon, 2 Oct 2017 09:01:31 +1100
Subject: [Intel-wired-lan] [PATCH 00/18] use ARRAY_SIZE macro
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Message-ID: <20171001220131.GA11812@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Oct 01, 2017 at 03:30:38PM -0400, J?r?my Lefaure wrote:
> Hi everyone,
> Using ARRAY_SIZE improves the code readability. I used coccinelle (I
> made a change to the array_size.cocci file [1]) to find several places
> where ARRAY_SIZE could be used instead of other macros or sizeof
> division.
> 
> I tried to divide the changes into a patch per subsystem (excepted for
> staging). If one of the patch should be split into several patches, let
> me know.
> 
> In order to reduce the size of the To: and Cc: lines, each patch of the
> series is sent only to the maintainers and lists concerned by the patch.
> This cover letter is sent to every list concerned by this series.

Why don't you just send individual patches for each subsystem? I'm not a maintainer but I don't see
how any one person is going to be able to apply this whole series, it is making it hard for
maintainers if they have to pick patches out from among the series (if indeed any will bother
doing that).

I get that this will be more work for you but AFAIK we are optimizing for maintainers.

Good luck,
Tobin.
