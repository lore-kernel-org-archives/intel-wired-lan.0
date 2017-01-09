From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 9 Jan 2017 12:55:43 +0000
Subject: [Intel-wired-lan] [RFC PATCH] intel: Use upper_32_bits and
	lower_32_bits
In-Reply-To: <7a5cfe63cad3ef4badc30cbc2185a5bfb9250fd8.1483813334.git.joe@perches.com>
References: <7a5cfe63cad3ef4badc30cbc2185a5bfb9250fd8.1483813334.git.joe@perches.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB025AC14@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Joe Perches
> Sent: 07 January 2017 18:33
> Shifting and masking various types can be made a bit
> simpler to read by using the available kernel macros.
...
> -		ew32(TDBAH, (tdba >> 32));
> -		ew32(TDBAL, (tdba & 0x00000000ffffffffULL));
> +		ew32(TDBAH, upper_32_bits(tdba));
> +		ew32(TDBAL, lower_32_bits(tdba));

Personally I find the original code easier to understand
since I don't have to look up another silly macro.

I'd normally not even explicitly mask the low bits
relying on the implicit truncation of the assignment.

At least modern compilers aren't stupid enough to add two
'mask with 0xff' instructions for:
	*uchar_ptr = (unsigned char)(foo & 0xff);

	David

